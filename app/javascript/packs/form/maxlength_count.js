const textarea = document.getElementById("textarea");
const button = document.getElementById("button");

// テキストエリアのmaxlength属性を取得し入力できる最大文字数を調べる
const maxTextNum = textarea.getAttribute("maxlength");
// ボタンの表示非表示を制御
const disabled = button.getAttribute("disabled");
// 残り文字数を表示する要素を追加
const textMessage = document.createElement('div');
const parent = textarea.parentElement;

parent.insertBefore(textMessage, textarea);
// 残り文字数を表示
textarea.addEventListener('keyup', function() {
  let currentTextNum = textarea.value.length;
  inputCount = maxTextNum - currentTextNum
  if (inputCount != 0)  {
    textMessage.innerHTML = '<p>残り' + (inputCount) + '文字数</p>';
    button.disabled = false;
  }else {
    textMessage.innerHTML = '<p style="color: red; text-align: center; border-radius: 20px;">文字数は' + maxTextNum + '文字までです</p>';
    button.disabled = true;
  }
});
