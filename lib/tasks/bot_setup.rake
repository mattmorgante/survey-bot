namespace :bot_setup do
  desc 'Create get started button'
  task get_started_button_create: :environment do
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'new_thread',
      call_to_actions: [
        {
          payload: 'SETUP_BOT'
        }
      ]
    }, access_token: ENV['ACCESS_TOKEN'])

    Rails.logger.info 'Get started button has been successfully set'
  end

  desc 'Create persistent menu'
  task persistent_menu_create: :environment do
    Facebook::Messenger::Thread.set({
      setting_type: 'call_to_actions',
      thread_state: 'existing_thread',
      call_to_actions: [
        {
          type: 'postback',
          title: 'Reset settings',
          payload: 'RESET'
        }
      ]
    }, access_token: ENV['ACCESS_TOKEN'])
  end
end