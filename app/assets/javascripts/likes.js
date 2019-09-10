// (function($){
//     $(function () {
//         $('.like-img').click(function(){
//             let elem = $(this); // по кот кликаем, указываем в начале, зафиксируем
//             let a = elem.children('a');
//             $.ajax({
//                 type: 'POST',
//                 url: a.attr('href'),// куда отправляем данные. путь к php файлу раньше писали
//                 // адрес предумываем с / от корня проекта
//                 data: {
//
//                 },// что отправл/ можно передавть строкой или обьектом
//                 success: function(result){
//                     if(result){ // при успешном выполнении
//                         elem.children(".heart").toggleClass('fas far');
//                     }
//                 }// то что выводится в функции php editRecommended попадает в result
//             }); // передаем обьект в скобках
//         });
//     });
// })(jQuery); // функция обертка, $ может использоваться еще не только JQuery
