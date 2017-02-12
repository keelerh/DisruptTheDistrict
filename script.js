$(function(){

  var annotation = $('#content').annotator();

  annotation.annotator('addPlugin', 'Store', {
    prefix: '/annotation',
    loadFromSearch : {
        page : current_page_id
    },
    annotationData : {
        page : current_page_id
    },
    urls: {
        create:  '/store',
        update:  '/update/:id',
        destroy: '/delete/:id',
        search:  '/search'
    }
  });
});
