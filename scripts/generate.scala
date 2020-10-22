import java.nio.charset.StandardCharsets

import $ivy.`com.google.guava:guava:18.0`
import $ivy.`com.lihaoyi::ammonite-ops:2.2.0`
import $ivy.`org.apache.commons:commons-compress:1.20`
import $ivy.`org.apache.jena:jena-arq:3.16.0`
import $ivy.`org.apache.jena:jena-core:3.16.0`
import ammonite.ops._
import org.apache.jena.graph.Node
import org.apache.jena.query.{Query, QueryFactory}
import org.apache.jena.sparql.algebra.op.{OpBGP, OpPath, OpTriple}
import org.apache.jena.sparql.algebra.{Algebra, Op, OpVisitorBase, OpWalker}
import org.apache.jena.sparql.path.{P_Link, P_Seq, PathVisitorBase}

import scala.collection.mutable.ListBuffer
import scala.jdk.CollectionConverters.ListHasAsScala

/**
 * generate usefull csv per cartridge
 *
amm generate.scala --stats ../stats --cartridges ../cartridges
 *
 * @param stats directory to deploy, e.g. '/var/www'
 */
//todo add dir
@main
def generate(stats: os.Path, cartridges: os.Path, debugprint: Boolean = false): Unit = {

  //val debugprint = false 
  val cartridgesIter = ls ! cartridges
  for (cartridge <- cartridgesIter) {
    val cartridgeName = (cartridge relativeTo pwd).last
    val outFile: os.Path = stats / (cartridgeName + ".tsv")
    val outFileNew: os.Path = stats / (cartridgeName + "_new.tsv")
    rm ! outFile
    rm ! outFileNew
	write.append(outFileNew, ("cartridge/publisher\tdataset\tpartition\tprop target(pt)\tdeepestProp\tgithub \n").getBytes(StandardCharsets.UTF_8))

    println("\n"+cartridgeName + " at " + cartridge)
   
    for (dataset <- ls ! cartridge) {

		val datasetName = dataset.last
	        var errCount = 0
		println("|>"+datasetName + " at " + dataset)

		for (partition <- (ls ! dataset).filter(!_.toString.endsWith(".md"))) {

		  val partitionName = partition.last
		  println("|->"+partitionName + " at " + partition)
		  
		    if((ls.rec ! partition).filter(_.toString.endsWith("links.construct")).isEmpty ){
				println ("WARNING no links.construct found")
				}
			 if((ls.rec ! partition).filter(_.toString.endsWith("export.construct")).isEmpty ){
				println ("ERROR: no export.construct found")
				System.exit(-1)
				}
			for (forValidation <- (ls.rec ! partition).filter(_.toString.endsWith(".construct"))) {
				try{
					val q = read ! forValidation
					val query: Query = QueryFactory.create(q);
					val op: Op = Algebra.compile(query);
				 } catch {
				case e: Exception => {
					System.err.println("::error ::"+" fix: " + forValidation)
					println(e.getMessage)
					errCount+=1
					System.exit(-1)
					}
			  }//end catch
			}


			for (queryFile <- (ls.rec ! partition).filter(_.toString.endsWith("pt-construct"))) {
                          val pt = queryFile.last.replace(".pt-construct", "")
			  print("|-->"+queryFile.last+ " | dbo:"+pt)
			  try {

				//todo add prefixes to queries
				//todo DONE(await check) "visit the algebra Ops and pick the most bottom prop"
				// see visitors https://jena.apache.org/documentation/query/manipulating_sparql_using_arq.html

				val q = read ! queryFile
				val query: Query = QueryFactory.create(q);
				val op: Op = Algebra.compile(query);

				val collector = new DeepPropVisitor()

				OpWalker.walk(op, collector);

				val deepestProp = collector.getProps().last
				if(debugprint){
					println("+- DeepProp:\n\t"+deepestProp)
					println("+- QUERY:\n\t" + query.toString().split("\n").mkString("\n\t"))
					println("+- OP:\n\t" + op.toString().split("\n").mkString("\n\t"))
				}
				val ghlink = s"https://github.com/dbpedia/dnkg-pilot/blob/master/cartridges/$cartridgeName/$datasetName/$partitionName/$pt.pt-construct"
				//NEW
				write.append(outFileNew, (cartridgeName + "\t" +datasetName+"\t" + partitionName + "\t" + pt + "\t" + deepestProp + "\t"+ghlink+"\n").getBytes(StandardCharsets.UTF_8))
				//TODO old one 
				write.append(outFile, (cartridgeName + "\t" + partitionName + "\t" + pt + "\t" + deepestProp + "\t"+ghlink+"\n").getBytes(StandardCharsets.UTF_8))
				println(" |-> OK")
			  } catch {
				case e: Exception => {
					System.err.println("Error in: " + queryFile)
					System.out.println("")
					e.printStackTrace()
					System.out.println("")
					System.out.println("::error ::"+" Error in " + queryFile)
					System.out.println("::warning ::"+" Error in: " + queryFile)
					println(e.getMessage)
					System.exit(-1)
					}
			  }//end catch
			}//end files
		}//end partition	
    }
  }
}

// TODO recursive walk execution
class DeepPropVisitor() extends OpVisitorBase {

  private val props = new ListBuffer[Node]()

  def getProps(): ListBuffer[Node] = {
    props
  }


  override def visit(opTriple: OpTriple): Unit = {
    props.append(opTriple.getTriple.getPredicate)
  }

  override def visit(opBGP: OpBGP): Unit = {
    opBGP.getPattern.getList.asScala.foreach(triple => {
      props.append(triple.getPredicate)
    })
  }

  override def visit(opPath: OpPath): Unit = {
    try {

      // TODO check obj binding
      val epv = new LastPathSegmentVisitor
      opPath.getTriplePath.getPath.visit(epv)
      props.append(epv.getLast)
    } catch {
      case e: Exception => println("###"); e.printStackTrace()
    }
  }

}

class LastPathSegmentVisitor() extends PathVisitorBase {

  private var last: Node = null

  def getLast: Node = {
    last
  }

  override def visit(pathNode: P_Link): Unit = {
    last = pathNode.getNode
  }

  override def visit(pathSeq: P_Seq): Unit = {
    pathSeq.getRight.visit(this)
  }
}
