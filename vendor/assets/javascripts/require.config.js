var jam = {
    "packages": [
        {
            "name": "backbone",
            "location": "../vendor/jam/backbone",
            "main": "backbone.js"
        },
        {
            "name": "backbone.layoutmanager",
            "location": "../vendor/jam/backbone.layoutmanager",
            "main": "backbone.layoutmanager.js"
        },
        {
            "name": "jquery",
            "location": "../vendor/jam/jquery",
            "main": "jquery.js"
        },
        {
            "name": "jquery-cookie-amd",
            "location": "../vendor/jam/jquery-cookie-amd",
            "main": "jquery.cookie.js"
        },
        {
            "name": "lodash",
            "location": "../vendor/jam/lodash",
            "main": "./lodash.js"
        },
        {
            "name": "socket.io",
            "location": "../vendor/jam/socket.io",
            "main": "socket.io.js"
        },
        {
            "name": "text",
            "location": "../vendor/jam/text",
            "main": "text.js"
        },
        {
            "name": "underscore",
            "location": "../vendor/jam/underscore",
            "main": "underscore.js"
        }
    ],
    "version": "0.2.13",
    "shim": {
        "backbone": {
            "deps": [
                "jquery",
                "lodash"
            ],
            "exports": "Backbone"
        },
        "backbone.layoutmanager": {
            "deps": [
                "jquery",
                "backbone",
                "lodash"
            ],
            "exports": "Backbone.LayoutManager"
        },
        "underscore": {
            "exports": "_"
        }
    }
};

if (typeof require !== "undefined" && require.config) {
    require.config({
    "packages": [
        {
            "name": "backbone",
            "location": "../vendor/jam/backbone",
            "main": "backbone.js"
        },
        {
            "name": "backbone.layoutmanager",
            "location": "../vendor/jam/backbone.layoutmanager",
            "main": "backbone.layoutmanager.js"
        },
        {
            "name": "jquery",
            "location": "../vendor/jam/jquery",
            "main": "jquery.js"
        },
        {
            "name": "jquery-cookie-amd",
            "location": "../vendor/jam/jquery-cookie-amd",
            "main": "jquery.cookie.js"
        },
        {
            "name": "lodash",
            "location": "../vendor/jam/lodash",
            "main": "./lodash.js"
        },
        {
            "name": "socket.io",
            "location": "../vendor/jam/socket.io",
            "main": "socket.io.js"
        },
        {
            "name": "text",
            "location": "../vendor/jam/text",
            "main": "text.js"
        },
        {
            "name": "underscore",
            "location": "../vendor/jam/underscore",
            "main": "underscore.js"
        }
    ],
    "shim": {
        "backbone": {
            "deps": [
                "jquery",
                "lodash"
            ],
            "exports": "Backbone"
        },
        "backbone.layoutmanager": {
            "deps": [
                "jquery",
                "backbone",
                "lodash"
            ],
            "exports": "Backbone.LayoutManager"
        },
        "underscore": {
            "exports": "_"
        }
    }
});
}
else {
    var require = {
    "packages": [
        {
            "name": "backbone",
            "location": "../vendor/jam/backbone",
            "main": "backbone.js"
        },
        {
            "name": "backbone.layoutmanager",
            "location": "../vendor/jam/backbone.layoutmanager",
            "main": "backbone.layoutmanager.js"
        },
        {
            "name": "jquery",
            "location": "../vendor/jam/jquery",
            "main": "jquery.js"
        },
        {
            "name": "jquery-cookie-amd",
            "location": "../vendor/jam/jquery-cookie-amd",
            "main": "jquery.cookie.js"
        },
        {
            "name": "lodash",
            "location": "../vendor/jam/lodash",
            "main": "./lodash.js"
        },
        {
            "name": "socket.io",
            "location": "../vendor/jam/socket.io",
            "main": "socket.io.js"
        },
        {
            "name": "text",
            "location": "../vendor/jam/text",
            "main": "text.js"
        },
        {
            "name": "underscore",
            "location": "../vendor/jam/underscore",
            "main": "underscore.js"
        }
    ],
    "shim": {
        "backbone": {
            "deps": [
                "jquery",
                "lodash"
            ],
            "exports": "Backbone"
        },
        "backbone.layoutmanager": {
            "deps": [
                "jquery",
                "backbone",
                "lodash"
            ],
            "exports": "Backbone.LayoutManager"
        },
        "underscore": {
            "exports": "_"
        }
    }
};
}

if (typeof exports !== "undefined" && typeof module !== "undefined") {
    module.exports = jam;
}
