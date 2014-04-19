$(function() {
var not_firend = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  //remote: '/users/index.json?q=%QUERY',
  prefetch: $('#add-contacts').attr('not-firend-url')
  //local: $.map(states, function(state) { return { value: state }; })
});
var in_firend = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  //remote: '/users/index.json?q=%QUERY',
  prefetch: $('#add-contacts').attr('in-firend-url')
  //local: $.map(states, function(state) { return { value: state }; })
});
 
// kicks off the loading/processing of `local` and `prefetch`
not_firend.initialize();
in_firend.initialize();
 
var add_contacts = $('#add-contacts').typeahead({
                      hint: true,
                      highlight: true,
                      minLength: 1
                    },
                    {
                      name: 'in_firend',
                      displayKey: 'name',
                      source: in_firend.ttAdapter(),
                      templates: {
                        header: '<h3 class="league-name">好友</h3>',
                        empty: [
                          '<div class="empty-message">',
                          '没有发现任何好友',
                          '</div>'
                        ].join('\n'),
                        suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
                      }
                    },
                    {
                      name: 'not_firend',
                      displayKey: 'name',
                      source: not_firend.ttAdapter(),
                      templates: {
                        header: '<h3 class="league-name">陌生人</h3>',
                        empty: [
                          '<div class="empty-message">',
                          '没有发现任何用户',
                          '</div>'
                        ].join('\n'),
                        suggestion: Handlebars.compile('<p><img src="{{avatar_small}}" class="img-circle"><strong>{{name}}</strong><br><small>{{department}}-{{user_type}}</small></p>')
                      }
                    });
add_contacts.on('typeahead:selected',function(evt,data){
  if (data['isfirend'] == 'false') {
    $.post(
          $('#add-contacts').attr('add-contacts-url'),
          {add_id: data.id},
          function(data){
            if (data['status'] == 'true') {
              var template = Handlebars.compile('<li ><a href="#" data-toggle="tooltip" title="{{depart}}-{{type}}"><small class="text-muted pull-right"><button type="button" class="btn btn-default btn-sm"><i class="fa fa-eye text-blue"></i></button> <button type="button" class="btn btn-default btn-sm"><i class="fa fa-times text-red"></i></button></small><img src="{{avatar}}" class="online"><span style="font-size: 18px;font-weight: bold;color: #3c8dbc">{{username}}</span></a></li>');
              $('#contacts-list').prepend(template({avatar:data['add_user']['avatar']['small']['url'],username:data['add_user']['username'],depart:data['department'],type:data['user_type']}));
              not_firend.clearPrefetchCache();
              in_firend.clearPrefetchCache();
              not_firend.initialize(true);
              in_firend.initialize(true);
              Messenger().post({message: data['message'],type: 'success',showCloseButton: true});
            } else{
              Messenger().post({message: data['message'],type: 'error',showCloseButton: true});
            }
          }
    );
  }
  else
  {
    alert('aa');
  }

});

});