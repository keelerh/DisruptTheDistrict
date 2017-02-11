var hltr = new TextHighlighter(document,{
  onAfterHighlight: function (range, highlight_span) {
    console.log(range);
  },
});
