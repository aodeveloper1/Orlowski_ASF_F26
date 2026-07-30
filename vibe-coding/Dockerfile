FROM node:latest

WORKDIR /app

COPY index.html .

EXPOSE 8080

CMD ["node", "-e", "require('http').createServer((req,res)=>{res.writeHead(200, {'Content-Type':'text/html'});res.end(require('fs').readFileSync('index.html'));}).listen(8080)"]
