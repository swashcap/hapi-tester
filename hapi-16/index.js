"use strict";

const hapi = require("hapi");

const server = new hapi.Server();

server.connection({
  host: "0.0.0.0",
  port: 3000,
  routes: {
    cors: {
      credentials: true,
      origin: ["*"]
    }
  }
});

server.route({
  method: "GET",
  path: "/",
  handler(request, reply) {
    reply("Hello world");
  }
});

server.start(error => {
  if (error) {
    console.error(error);
    process.exit(1);
  }

  console.log(`Server running at: ${server.info.uri}`);
});
