$(function() {
	//クリックしたときのファンクションをまとめて指定
	$('.nav-link').click(function() {
		//.index()を使いクリックされたタブが何番目かを調べ、
		//indexという変数に代入します。
		var index = $('.nav-link').index(this);

		//コンテンツを一度すべて非表示にし、
		$('.tab-pane').css('display','none');

		//クリックされたタブと同じ順番のコンテンツを表示します。
		$('.tab-pane').eq(index).css('display','block');

		//一度タブについているクラスselectを消し、
		$(!this).removeClass('active');

		//クリックされたタブのみにクラスselectをつけます。
		$(this).addClass('active')
		
	});
});