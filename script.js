jQuery(function ($) {
  if (typeof $.fn.annotator !== 'function') {
    alert("Ooops! it looks like you haven't built the Annotator concatenation file. " +
          "Either download a tagged release from GitHub, or modify the Cakefile to point " +
          "at your copy of the YUI compressor and run `cake package`.");
  } else {
    $('#content').annotator()
                 .annotator('addPlugin', 'Auth', {
                    // userId:    'bill',
                    // userName:  'Bill',
                    // accountId: '123',
                    token: 'eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJ1c2VySWQiOiAia2VlbGV5IiwgInR0bCI6IDg2NDAwLCAiY29uc3VtZXJLZXkiOiAiYW5ub3RhdGVpdCIsICJpc3N1ZWRBdCI6ICIyMDE3LTAyLTEyVDE3OjEyOjIxKzAwOjAwIn0.rSYAqopfeci7TFy7zEJirzZFPW76rBBAPgcrWTwwn0k',
                    autoFetch: false
                  })
                //  .annotator('addPlugin', 'Auth', {
                //   tokenUrl: 'http://annotateit.org/api/token'
                //  })
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
