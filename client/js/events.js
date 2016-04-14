'use strict';

let listeners = [];

function unlisten(messageClass) {
    listeners[messageClass] = [];
}

function listen(messageClass, handler) {
    if (!(messageClass in listeners)) {
        listeners[messageClass] = [];
    }
    listeners[messageClass].push(handler);
}

function notify(messageClass, message) {
    if (!(messageClass in listeners)) {
        return;
    }
    for (let handler of listeners[messageClass]) {
        handler(message);
    }
}

module.exports = {
    Success: 1,
    Error: 2,
    Info: 3,
    Authentication: 4,
    SettingsChange: 5,

    notify: notify,
    listen: listen,
    unlisten: unlisten,
};