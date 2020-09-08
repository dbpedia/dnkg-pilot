var http = require("http"),
    exec = require("child_process").exec;

function onRequest(request, response) {
  response.writeHead(200, {"Content-Type": "text/csv"});
  exec('sh equivalentProperty.sh', function (err, stdout, stderr) {
    console.log(stdout);
    response.write(stdout);
    response.end();
  });
}
http.createServer(onRequest).listen(8888, function () {
  console.log("Server has started.");
});

