# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:


* SET UP GREETINGS MESSAGE
curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type":"greeting",
  "greeting":{
    "text":"Welcome to Vegaroo!"
  }
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=EAAF49ippZBVMBABJNDgMnQUEN8uyZAxYqTW7IRYPgb8cyWn2f9udixUU0vovA3d7zGerlXK5BF6eOFx0LUgYTNJ9MYHRJPXKqpZBVZAOYHZAcod1j6gdl0Ft8PR98ZBLvf8ZCw5wS3FP7gTOHqi2CQvBo4LQ4K9QZAnZA2Wr6RF9DfgZDZD"    

* SET UP FIRST ACTION PLAYLOAD
curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type":"call_to_actions",
  "thread_state":"new_thread",
  "call_to_actions":[
    {
      "payload":"START_USER_SURVEY"
    }
  ]
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=EAAF49ippZBVMBABJNDgMnQUEN8uyZAxYqTW7IRYPgb8cyWn2f9udixUU0vovA3d7zGerlXK5BF6eOFx0LUgYTNJ9MYHRJPXKqpZBVZAOYHZAcod1j6gdl0Ft8PR98ZBLvf8ZCw5wS3FP7gTOHqi2CQvBo4LQ4K9QZAnZA2Wr6RF9DfgZDZD"    