{%- extends 'slides_reveal.tpl' -%}

{% block header %}
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />

<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

<title>{{resources['metadata']['name']}} slides</title>

<script src="src/require.js/2.1.10/require.min.js"></script>
<script src="src/jquery/2.0.3/jquery.min.js"></script>

<!-- General and theme style sheets -->
<link rel="stylesheet" href="{{resources.reveal.url_prefix}}/css/reveal.css">
<link rel="stylesheet" href="{{resources.reveal.url_prefix}}/css/theme/{{resources.reveal.theme}}.css" id="theme">

<!-- If the query includes 'print-pdf', include the PDF print sheet -->
<script>
if( window.location.search.match( /print-pdf/gi ) ) {
        var link = document.createElement( 'link' );
        link.rel = 'stylesheet';
        link.type = 'text/css';
        link.href = '{{resources.reveal.url_prefix}}/css/print/pdf.css';
        document.getElementsByTagName( 'head' )[0].appendChild( link );
}
</script>

<!--[if lt IE 9]>
<script src="{{resources.reveal.url_prefix}}/lib/js/html5shiv.js"></script>
<![endif]-->

<!-- Loading the mathjax macro -->
{{ mathjax(url="src/MathJax-2.7.1/") }}

<!-- Get Font-awesome from cdn -->
<link rel="stylesheet" href="src/font-awesome/4.1.0/css/font-awesome.css">

{% for css in resources.inlining.css -%}
    <style type="text/css">
    {{ css }}
    </style>
{% endfor %}

<style type="text/css">
/* Overrides of notebook CSS for static HTML export */
.reveal {
  font-size: 160%;
  overflow-y: scroll;
}
.reveal pre {
  width: inherit;
  padding: 0.4em;
  margin: 0px;
  font-family: monospace, sans-serif;
  font-size: 80%;
  box-shadow: 0px 0px 0px rgba(0, 0, 0, 0);
}
.reveal pre code {
  padding: 0px;
}
.reveal section img {
  border: 0px solid black;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0);
}
.reveal i {
  font-style: normal;
  font-family: FontAwesome;
  font-size: 2em;
}
.reveal .slides {
  text-align: left;
}
.reveal.fade {
  opacity: 1;
}
.reveal .progress {
  position: static;
}
div.input_area {
  padding: 0.06em;
}
div.code_cell {
  background-color: transparent;
}
div.prompt {
  width: 11ex;
  padding: 0.4em;
  margin: 0px;
  font-family: monospace, sans-serif;
  font-size: 80%;
  text-align: right;
}
div.output_area pre {
  font-family: monospace, sans-serif;
  font-size: 80%;
}
div.output_prompt {
  /* 5px right shift to account for margin in parent container */
  margin: 5px 5px 0 0;
}
div.text_cell.rendered .rendered_html {
  /* The H1 height seems miscalculated, we are just hidding the scrollbar */
  overflow-y: hidden;
}
a.anchor-link {
  /* There is still an anchor, we are only hidding it */
  display: none;
}
.rendered_html p {
  text-align: inherit;
}
</style>

<!-- Custom stylesheet, it must be in the same directory as the html file -->
<link rel="stylesheet" href="custom.css">

</head>
{% endblock header%}

{% block post_slides %}

<script>
  require(
    {
      // it makes sense to wait a little bit when you are loading
      // reveal from a cdn in a slow connection environment
      // waitSeconds: 15
    },
    [
      "{{resources.reveal.url_prefix}}/lib/js/head.min.js",
      "{{resources.reveal.url_prefix}}/js/reveal.js"
    ],
    function(head, Reveal){
        // Full list of configuration options available here: https://github.com/hakimel/reveal.js#configuration
        Reveal.initialize({
            controls: true,
            progress: true,
            history: true,
            theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
            transition: Reveal.getQueryHash().transition || 'linear', // default/cube/page/concave/zoom/linear/none

            controlsLayout: "edges",
            
            //size
            width: '80%',

            parallaxBackgroundImage: 'images/background_1.jpg',
            parallaxBackgroundSize: '3800px 1200px',


            // Optional libraries used to extend on reveal.js
            dependencies: [
                { src: "{{resources.reveal.url_prefix}}/lib/js/classList.js",
                  condition: function() { return !document.body.classList; } },
                { src: "{{resources.reveal.url_prefix}}/plugin/notes/notes.js",
                  async: true,
                  condition: function() { return !!document.body.classList; } }
            ]
        });
        Reveal.configure({
          keyboard: {
            40: 'next',
            38: 'prev'
          }
        });
          var update = function(event){
          if(MathJax.Hub.getAllJax(Reveal.getCurrentSlide())){
            MathJax.Hub.Rerender(Reveal.getCurrentSlide());
          }
        };
        Reveal.addEventListener('slidechanged', update);
        var update_scroll = function(event){
          $(".reveal").scrollTop(0);
        };
        Reveal.addEventListener('slidechanged', update_scroll);
    }
);
</script>

</body>
{% endblock post_slides %}
