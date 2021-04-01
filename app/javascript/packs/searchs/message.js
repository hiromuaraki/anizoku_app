jQuery(document).ready(function($){
  $("input").each(function(index, element) {

      element.addEventListener("invalid", function(e) {
          if(element.validity.valueMissing){
              e.target.setCustomValidity("「作品名」もしくは「キャラクター名」を入力し検索してください。");
          } else {
              e.target.setCustomValidity("");
              e.preventDefault();
          }
      });
  });
});
