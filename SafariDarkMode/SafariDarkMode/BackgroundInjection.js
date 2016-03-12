var d = document,
    dl = d.location,
    w = window;

function injectStyle(css,id) {
    if (!dl.host) return;
    //	if (w != w.top) return;
    removeStyle(id);
    var regex_timer = /\?timer=(.\d)/gi,
    regex_rnd = /\?rnd=(.\d)/gi,
    time = (new Date()).getTime(),
    timer = function(s,n) {return '?timer='+Math.floor(time/(1000*parseInt(n)))}, // Cahche images for 10 minutes
    rnd = '?rnd='+Math.random(),
    style = d.createElement('style');
    style.setAttribute('id', '' + id);
    style.style.display = 'none !important';
    style.setAttribute('type', 'text/css');
    css = minify_css(css);
    style.innerText = css.replace(regex_timer,timer).replace(regex_rnd,rnd);
    (d.head || d.documentElement).appendChild(style, null);
}

function removeStyle(id) {
    if (e = d.getElementById(''+id)) e.parentNode.removeChild(e);
}

function minify_css(css){
    var patterns = [
                    [ '\\/\\*.*?\\*\/',''],
                    [ '\\s+',' ']
                    ];
    patterns.map(function(pattern){
                 css = css.replace(new RegExp(pattern[0],"g"),pattern[1]);
                 });
    return css.trim();
}

function log(l) {
    console.log('injected: ',l);
};
