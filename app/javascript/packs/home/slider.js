document.addEventListener("DOMContentLoaded", function(){
  var mySwiper = new Swiper('.swiper-container', {
	  slidesPerView: 3,
    // slidesPerColumn: 3,
    // slidesPerGroup: 2,
    spaceBetween: 10,
    speed: 1000,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev'
    },
    pagination: {
      el: ".swiper-pagination",
      type: 'bullets',
      clickable: true
    },
  });
});