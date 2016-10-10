$(function(){
    var setFileInput = $('.js-imgInput'),
    setFileImg = $('.js-imgView');

    var selfFile = $(this),
    selfInput = $(this).find('input[type=file]'),
    prevElm = selfFile.find(setFileImg),
    orgPass = prevElm.attr('src');

    selfInput.change(function(){
        console.log('aaa')
        var file = $(this).prop('files')[0],
        fileRdr = new FileReader();

        if (!this.files.length){
            prevElm.attr('src', orgPass);
            return;
        } else {
            if (!file.type.match('image.*')){
                prevElm.attr('src', orgPass);
                return;
            } else {
                fileRdr.onload = function() {
                    prevElm.attr('src', fileRdr.result);
                }
                fileRdr.readAsDataURL(file);
            }
        }
    });
});
