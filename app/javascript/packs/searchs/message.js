jQuery(document).ready(function($){
 jQuery("input").each(function(index, element) {

      element.addEventListener("invalid", function(e) {
          if(element.validity.valueMissing){
              e.target.setCustomValidity("「作品名」を入力して検索してください。");
          } else {
              e.target.setCustomValidity("");
              e.preventDefault();
          }
      });
  });
});
