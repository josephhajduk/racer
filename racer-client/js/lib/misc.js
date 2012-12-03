var requestAnimFrame = (function(callback) {
    return window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        window.oRequestAnimationFrame ||
        window.msRequestAnimationFrame ||
        function(callback) {
            window.setTimeout(callback, 1000 / 60);
        };
})();

var sum = function(a) {
    result = 0
    for (var i = 0; i < a.length; i ++){
        result += a[i]
    }
    return result
}

var zip = function(a,b) {
    result = []
    for (var i = 0; i < a.length; i ++){
        result.push([a[i],b[i]])
    }
    return result
}

var range = function(n) {
    result = []
    for (var i = 0; i < n; i++) {
        result.push(i)
    }
    return result
}