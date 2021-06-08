document.addEventListener("DOMContentLoaded", function(){
  var mySwiper = new Swiper('.swiper-container', {
	  slidesPerView: 3,
    loop: true,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    centeredSlides: true,
    // slidesPerColumn: 3,
    // slidesPerGroup: 2,
    // spaceBetween: 10,
    speed: 500,
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