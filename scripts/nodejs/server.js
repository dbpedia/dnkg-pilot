var http = require("http"),
    exec = require("child_process").exec;
var url = require("url");

function onRequest(request, response) {
	//EXAMPLES
	//http://95.217.38.103:8888?type=gfs&url=https://global.dbpedia.org/property/69VK --> gfs.sg
	//http://95.217.38.103:8888 --> equivalentProperty.sh
	var url_parts = url.parse(request.url,true);
	var query = url_parts.query;
	var queryURL = query.url;
	var queryType = query.type;
	console.log(queryURL + " " + queryType);
	if(queryType == "gfs"){
		response.writeHead(200, {"Content-Type": "text/csv"});
		exec("sh gfs.sh " + query.url, function (err, stdout, stderr) {
			console.log(stdout);
			response.write(stdout);
			response.end();
		});
	}else{
		response.writeHead(200, {"Content-Type": "text/csv"});
  		exec('sh equivalentProperty.sh', function (err, stdout, stderr) {
    			console.log(stdout);
		    	response.write(stdout);
    			response.end();
  		});
	}
}
http.createServer(onRequest).listen(8888, function () {
  console.log("Server has started.");
});

