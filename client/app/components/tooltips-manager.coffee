###
This component must be used to declare tooltips.
They can't be then referenced from the other components.

See https://github.com/m4dz/aria-tips#use
###

{Tooltips} = require '../constants/app_constants'
{div, p} = React.DOM

module.exports = React.createClass
    displayName: 'TooltipManager'

    render: ->

        # Mounts all existing tooltips so they can be referenced by other
        # components at any time.
        div null,
            @getTooltip Tooltips.REPLY, t('tooltip reply')
            @getTooltip Tooltips.REPLY_ALL, t('tooltip reply all')
            @getTooltip Tooltips.FORWARD, t('tooltip forward')
            @getTooltip Tooltips.REMOVE_MESSAGE, t('tooltip remove message')
            @getTooltip Tooltips.OPEN_ATTACHMENTS, t('tooltip open attachments')
            @getTooltip Tooltips.OPEN_ATTACHMENT, t('tooltip open attachment')
            @getTooltip Tooltips.DOWNLOAD_ATTACHMENT, t('tooltip download attachment')
            @getTooltip Tooltips.PREVIOUS_CONVERSATION, t('tooltip previous conversation')
            @getTooltip Tooltips.NEXT_CONVERSATION, t('tooltip next conversation')


    # Generate default markup for a tooltip.
    getTooltip: (id, content) ->
        return p
            id: id
            role: "tooltip"
            'aria-hidden': "true",
            content




