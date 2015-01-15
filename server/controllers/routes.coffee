# See documentation on https://github.com/frankrousseau/americano#routes

index     = require './index'
accounts  = require './accounts'
activity  = require './activity'
mailboxes = require './mailboxes'
messages  = require './messages'
providers = require './providers'
settings  = require './settings'
test      = require './test'

module.exports =

    '': get: index.main

    'refreshes': get: index.refreshes
    'refresh': get: index.refresh

    'settings':
        get: settings.get
        put: settings.change

    'activity':
        post: activity.create

    'account':
        post: [accounts.create, accounts.format]
        get: [accounts.list, accounts.formatList]

    'account/:accountID':
        get: [accounts.fetch, accounts.format]
        put: [accounts.fetch, accounts.edit, accounts.format]
        delete: [accounts.fetch, accounts.remove]

    'conversation/:conversationID':
        get: [messages.fetchConversation, messages.conversationGet]
        delete: [messages.fetchConversation, messages.conversationDelete]
        patch: [messages.fetchConversation, messages.conversationPatch]

    'mailbox':
        post: [accounts.fetch,
            mailboxes.fetchParent,
            mailboxes.create,
            accounts.format]

    'mailbox/:mailboxID':
        get: [messages.listByMailboxOptions,
              messages.listByMailbox]

        put: [mailboxes.fetch,
              accounts.fetch,
              mailboxes.update,
              accounts.format]

        delete: [mailboxes.fetch,
            accounts.fetch,
            mailboxes.delete,
            accounts.format]

    'message':
        post: [messages.parseSendForm,
               accounts.fetch,
               messages.fetchMaybe,
               messages.send]

    'message/:messageID':
        get: [messages.fetch, messages.details]
        patch: [messages.fetch, messages.patch]

    'message/:messageID/attachments/:attachment':
        get: [messages.fetch, messages.attachment]

    'provider/:domain':
        get: providers.get

    'load-fixtures':
        get: index.loadFixtures

    'test': get: test.main

    'raw/:mailboxID/:messageID':
        get: [mailboxes.fetch, messages.raw]
