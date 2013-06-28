require.config({
    paths: {
        jquery: 'libs/jquery',
    },
});

require(['app', 'jquery', 'mood'], function (app, $, mood) {
    'use strict';
    // use app here
    console.log(app);
});
