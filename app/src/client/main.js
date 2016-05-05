import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

Template.hello.helpers({
  items: function() {
    return Template.instance()._items.get();
  },
  counter() {
    return Template.instance().counter.get();
  },
});

Template.hello.onCreated(function helloOnCreated() {
  // counter starts at 0
  this.counter = new ReactiveVar(0);

  this._items = new ReactiveVar([]);
  this.firebaseRef = new Firebase('https://amber-heat-3398.firebaseio.com/');

  firebaseRef.on('child_added', function(snapshot) {
    console.log(snapshot);
    var newItem = snapshot.val();
    var items = this._items.get();
    this._items.set(users.concat(newItem));
  }.bind(this));

});

Template.hello.events({
  'click button'(event, instance) {
    // increment the counter when button is clicked
    instance.counter.set(instance.counter.get() + 1);
  },
});
