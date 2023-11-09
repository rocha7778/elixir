function() {

  var env = karate.env; // get java system property 'karate.env'
  var endpoint = karate.properties['karate.endpoint'];
  var keyPath = karate.properties['karate.keyPath'] || 'security/keystore.jks'; // path to keystore
  var keyPassword = karate.properties['karate.keyPassword'] || '123456789'; // password to keystore
  var userAuth = karate.properties['karate.userAuth'] || 'user1'; // user to basic auth
  var passAuth = karate.properties['karate.passAuth'] || 'wrongpass'; // pass to basic auth

  if (!env) {
    env = 'local'; // a custom 'intelligent' default
  }

    if (!endpoint) {
      endpoint = 'https://localhost:8081';
    }

   var temp = userAuth + ':' + passAuth;
   var Base64 = Java.type('java.util.Base64');
   var encodedi = 'Basic ' + Base64.getEncoder().encodeToString(temp.getBytes());
   var sslStringConfig = '{ "keyStore": "'+ keyPath+'", "keyStorePassword": "'+keyPassword+'", "algorithm": "TLSv1.2"}';
   var sslJSON = JSON.parse(sslStringConfig);

  var config = { // base config JSON
    appId: 'my.app.id',
    appSecret: 'my.secret',
    endpoint: endpoint,
    sslJSON: sslJSON,
    encodedi: encodedi,
  };

  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 50000);
  karate.configure('readTimeout', 50000);

  return config;

}