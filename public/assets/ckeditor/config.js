CKEDITOR.editorConfig = function (config) {
  config.toolbar_body = [
    {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline']},
    {name: 'clipboard', items: ['RemoveFormat', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo']},
    {name: 'links', items: ['Link', 'Unlink']},
    {name: 'paragraph', items: ['BulletedList', 'NumberedList']},
    {name: 'styles', items: ['Format']},
    {name: 'embed', items: ['Embed']}
  ];

  config.toolbar_simple = [
    {name: 'basicstyles', items: ['RemoveFormat', 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript']},
    {name: 'links', items: ['Link', 'Unlink']},
    {name: 'paragraph', items: ['BulletedList', 'NumberedList']},
    {name: 'insert', items: ['SpecialChar']},
    {name: 'colors', items: ['TextColor', 'BGColor']}
  ];

  config.toolbar_simplest = [
    {name: 'all', items: ['Bold', 'Italic', 'Underline','Link','BulletedList']}
  ];
};
