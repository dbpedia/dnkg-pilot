import java.net.URI
import java.nio.charset.StandardCharsets
import java.nio.file.{Files, Paths, StandardOpenOption}

import $ivy.`org.apache.commons:commons-compress:1.20`
import org.apache.commons.compress.compressors.bzip2._

import $ivy.`com.lihaoyi::ammonite-ops:2.2.0`
import $ivy.`com.google.guava:guava:18.0`
import $ivy.`org.apache.jena:jena-core:3.16.0`
import $ivy.`org.apache.jena:jena-arq:3.16.0`
import ammonite.ops._
import java.io.File
import java.net.URL
import java.net.URLEncoder
import org.apache.jena.query.Query
import org.apache.jena.query.QueryFactory
import org.apache.jena.sparql.algebra.Algebra 
import org.apache.jena.sparql.algebra.Op




/**
  * generate usefull csv per cartridge 
  *
  * amm ./generate.sc split --dir ""
  *
  * @param dir directory to deploy, e.g. '/var/www'
  */
//todo add dir  
@main
def generate(): Unit = {
	val dir = pwd

  val cartridges = ls! (pwd/"cartridges")
  for (c <- cartridges){
	  val cartname = (c relativeTo pwd).last
      val outFile:os.Path = dir/(cartname+".tsv")
	  rm! outFile

	  println("############")
	  println(cartname)
	  println("############")


	  for (f <- (ls.rec! c).filter(_.toString.endsWith("pt-construct")) ){
		val pt = f.last.replace(".pt-construct","")  
		println(pt)
		try{
			
			
		//todo add prefixes to queries
		//todo "visit the algebra Ops and pick the most bottom prop "
		// see visitors https://jena.apache.org/documentation/query/manipulating_sparql_using_arq.html

		val q = read! f
		val query:Query = QueryFactory.create(q) ;
        val op:Op = Algebra.compile(query) ;
        
        println(q)
        println(query)
        println(op)
} catch {case e:Exception => println("fix "+f);println(e)}
        // todo use algebra to get "deepest" prop
        val deepestProp = "http://todo.org/"
        
       
		write.append(outFile,(pt+"\t"+deepestProp+"\n").getBytes(StandardCharsets.UTF_8))
	  }
   }
   

}

