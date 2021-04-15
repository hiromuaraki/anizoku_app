jQuery(function() {
	//クリックしたときのファンクションをまとめて指定
	jQuery('.nav-link').click(function() {
		var index = jQuery('.nav-link').index(this);
		//コンテンツを一度すべて非表示にし、
		jQuery('.tab-pane').css('display','none');
 
		//クリックされたタブと同じ順番のコンテンツを表示します。
		jQuery('.tab-pane').eq(index).css('display','block');

		//クリックされたタブのみにactiveをつける
		// $('.nav-tabs a[href="#' + this.id + '"]').tab( 'show' );
		jQuery('.nav-tabs a[href="#' + "work-tab" + '"]').attr( 'data-toggle', 'tab' );
	});
});
