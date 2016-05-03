var Firebase = Meteor.npmRequire("firebase");

var firebase = new Firebase('https://amber-heat-3398.firebaseio.com/');
firebase.on('child_added',   willLog);
firebase.on('child_changed', willLog);
firebase.on('child_removed', willLog);

function willLog(snapshot) {
  console.log(snapshot.key() + " : " + EJSON.stringify(snapshot.val()));
}
