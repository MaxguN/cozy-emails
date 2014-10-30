americano = require 'americano'

module.exports =
    settings:
        all: americano.defaultRequests.all

    account:
        all: americano.defaultRequests.all

    contact:
        all: americano.defaultRequests.all
        byName: (doc) ->
            if doc.fn? and doc.fn.length > 0
                emit doc.fn, doc
            if doc.n?
                emit doc.n.split(';').join(' ').trim(), doc
            for dp in doc.datapoints
                if dp.name is 'email'
                    emit dp.value, doc
                    emit dp.value.split('@')[1], doc

    mailbox:
        treeMap: (doc) ->
            emit [doc.accountID].concat(doc.tree), null

    message:

        byMailboxRequest:
            reduce: '_count'
            map: (doc) ->
                for boxid, uid of doc.mailboxIDs
                    emit ['uid', boxid, uid], doc.flags

                    emit ['date', boxid, null, doc.date], null
                    emit ['subject', boxid, null, doc.normSubject], null

                    for xflag in ['\\Seen', '\\Flagged', '\\Answered']

                        xflag = '!' + xflag if -1 is doc.flags.indexOf(xflag)

                        emit ['date', boxid, xflag, doc.date], null
                        emit ['subject', boxid, xflag, doc.normSubject], null
                undefined # prevent coffeescript comprehension

        # this map is used to dedup by message-id
        dedupRequest: (doc) ->
            if doc.messageID
                emit [doc.accountID, 'mid', doc.messageID], doc.conversationID

            if doc.normSubject
                emit [doc.accountID, 'subject', doc.normSubject], doc.conversationID
