jQuery(function ($) {
  if (typeof $.fn.annotator !== 'function') {
    alert("Ooops! it looks like you haven't built the Annotator concatenation file. " +
          "Either download a tagged release from GitHub, or modify the Cakefile to point " +
          "at your copy of the YUI compressor and run `cake package`.");
  } else {
    $('#content').annotator()
                 .annotator('addPlugin', 'Auth', {
                  tokenUrl: 'http://annotateit.org/api/token'
                 })
                 .annotator('addPlugin', 'Store', {
                  prefix: 'http://annotateit.org/api',
                  loadFromSearch: {
                    'limit': 20,
                  },
                  urls: {
                    update: '/annotations/:id'
                  }
                 });
  }
});
