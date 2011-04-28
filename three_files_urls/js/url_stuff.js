#!/usr/bin/env node

var h = [];
var stdin = process.openStdin();
stdin.setEncoding('utf8');

/* Process stdin */
var regexp = /embedCode=(\w+)/g;
stdin.on('data', function(line) {
  //process.stdout.write(line);
  while (match = regexp.exec(line)) { 
    h[match[1]] = 1; 
  }
});

/* When done, dump results */
process.stdin.on("end", function() {
  for (var k in h) { process.stdout.write(k + "\n"); }
});
