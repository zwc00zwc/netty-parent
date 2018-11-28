var receiveRedbagTable;
$(function () {
    receiveRedbagTableList();
    searchReceiveRedbagList();
})

function receiveRedbagTableList() {
    receiveRedbagTable = $('#receiveRedbag_table').dataTable({
        language: datatable_zn,
        'bAutoWidth': false,
        'bFilter': false,
        'bProcessing': false,
        'bSort': false,
        'bServerSide': true,
        'fnServerParams': function (aoData) {
            getAllSearchValue(aoData);
        },
        'sAjaxSource': '/sys/ajaxReceiveRedbag',
        "createdRow": function (row, data, index) {
            $('td', row).eq(5).css('text-align', "center");
        },
        'aoColumns': [
            {
                'mDataProp': 'id',
                'bSortable': false
            }, {
                'mDataProp': 'sendUserName',
                'bSortable': false
            }, {
                'mDataProp': 'receiveUserName',
                'bSortable': false
            }, {
                'mDataProp': 'amount',
                'bSortable': false
            }, {
                'mDataProp': 'status',
                'bSortable': false,
                'mRender': function (data, type, row) {
                    if (data == 1){
                        return "";
                    }
                    return data;
                }
            }, {
                'mDataProp': 'remark',
                'bSortable': false
            }, {
                'mDataProp': 'createTime',
                'bSortable': false,
                'mRender': function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                }
            }, {
                'mDataProp': 'operation',
                'bSortable': false,
                'mRender': function (data, type, row) {
                    return getAllOperation(row);
                }
            }
        ]
    });
}

function getAllSearchValue(aoData) {
    aoData.push({
        "name": 'id',
        "value": trimStr($('#id').val())
    });
    aoData.push({
        "name": 'redbagId',
        "value": trimStr($('#redbagId').val())
    });
    aoData.push({
        "name": 'receiverName',
        "value": trimStr($('#receiverName').val())
    });
    aoData.push({
        "name": 'status',
        "value": trimStr($('#status').val())
    });
}

function searchReceiveRedbagList() {
    $("#search").on("click", function () {
        receiveRedbagTable.fnDraw();
    });
}

function getAllOperation(row) {
    var btn = '';
    var edit = '<input id="edit" data-id="' + row.id + '" class="btn btn-secondary radius" type="button" value="修改">';
    var remove = '<input id="remove" data-id="' + row.id + '" class="btn btn-danger radius" type="button" value="删除">';
    if ($.inArray("sys:addUser", permUrls) > 0) {
        btn += edit;
    }
    if ($.inArray("sys:removeUser", permUrls) > 0) {
        btn += remove;
    }
    return btn;
}

$("#member_table").on("click", '#edit', function () {
    var id = $(this).attr("data-id");
    layer_show('编辑用户', '/sys/addUser?id=' + id + '', '', '510');
});

$("#member_table").on("click", '#remove', function () {
    var id = $(this).attr("data-id");
    layer.confirm('确认要删除吗？', function (index) {
        $.post(
            '/Sys/Remove', { id: id}, function (data) {
                if (data.success) {
                    layer.msg('操作成功', { icon: 1, time: 1000 });
                    memberTable.fnDraw();
                } else {
                    layer.msg(data.errorDesc, { icon: 5, time: 1000 });
                }
            }
        );
    });
});