CKEDITOR.config.customConfig = 'ck_config.js';

$(document).ready(function(){
  /*https://stackoverflow.com/questions/8279859/get-first-letter-of-each-word-in-a-string-in-javascript*/
  function updateSuffix(){
    $("#requirement_suffix").val('R'+$("#requirement_category").val().match(/\b\w/g).join('').toUpperCase());
  }

  $(document).on("input", "#requirement_category", updateSuffix);
});


