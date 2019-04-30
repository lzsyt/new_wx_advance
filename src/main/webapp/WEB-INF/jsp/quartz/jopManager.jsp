<%--
  Created by IntelliJ IDEA.
  User: 23108
  Date: 2019/4/24
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>QuartzDemo</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui@2.0.5/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="http://cdn.bootcss.com/vue-resource/1.3.4/vue-resource.js"></script>
    <script src="https://unpkg.com/element-ui@2.0.5/lib/index.js"></script>

    <style>
        #top {
            background:#20A0FF;
            padding:5px;
            overflow:hidden
        }
    </style>

</head>
<body>
<div id="test">

    <div id="top">
        <el-button type="text" @click="search" style="color:white">查询</el-button>
        <el-button type="text" @click="handleadd" style="color:white">添加</el-button>
        </span>
    </div>

    <br/>

    <div style="margin-top:15px">

        <el-table
                ref="testTable"
                :data="tableData"
                style="width:100%"
                border
        >
            <el-table-column
                    prop="job_NAME"
                    label="任务名称"
                    sortable
                    show-overflow-tooltip>
            </el-table-column>

            <el-table-column
                    prop="job_GROUP"
                    label="任务所在组"
                    sortable>
            </el-table-column>

            <el-table-column
                    prop="job_CLASS_NAME"
                    label="任务类名"
                    sortable>
            </el-table-column>

            <el-table-column
                    prop="trigger_NAME"
                    label="触发器名称"
                    sortable>
            </el-table-column>

            <el-table-column
                    prop="trigger_GROUP"
                    label="触发器所在组"
                    sortable>
            </el-table-column>

            <el-table-column
                    prop="cron_EXPRESSION"
                    label="表达式"
                    sortable>
            </el-table-column>

            <el-table-column
                    prop="time_ZONE_ID"
                    label="时区"
                    sortable>
            </el-table-column>

            <el-table-column label="操作" width="300">
                <template scope="scope">
                    <el-button
                            size="small"
                            type="warning"
                            @click="handlePause(scope.$index, scope.row)">暂停</el-button>

                    <el-button
                            size="small"
                            type="info"
                            @click="handleResume(scope.$index, scope.row)">恢复</el-button>

                    <el-button
                            size="small"
                            type="danger"
                            @click="handleDelete(scope.$index, scope.row)">删除</el-button>

                    <el-button
                            size="small"
                            type="success"
                            @click="handleUpdate(scope.$index, scope.row)">修改</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div align="center">
            <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="currentPage"
                    :page-sizes="[10, 20, 30, 40]"
                    :page-size="pagesize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="totalCount">
            </el-pagination>
        </div>
    </div>
    <el-dialog title="选择任务" :visible.sync="checkboxChange">
        <el-radio-group v-model="ruleForm.resource">
            <el-radio :label="3">Simple Trigger</el-radio>
            <el-radio :label="6">Cron Trigger</el-radio>
        </el-radio-group>
        <div slot="footer" class="dialog-footer">
            <el-button @click="checkboxChange = false">取 消</el-button>
            <el-button type="primary" @click="change">确 定</el-button>
        </div>
    </el-dialog>
    <el-dialog title="添加任务" :visible.sync="dialogFormVisibleChange" v-if="ruleForm.resource==3">
        <el-form :model="form" >
            <el-form-item label="任务名称" label-width="120px" style="width:35%">
                <el-input v-model="form.jobName" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="任务分组" label-width="120px" style="width:35%">
                <el-input v-model="form.jobGroup" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="多久之后执行" label-width="120px" style="width:35%">
                <el-input v-model="form.cronExpression" auto-complete="off"></el-input>

                <el-select v-model="value4"  placeholder="请选择">
                    <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisibleChange = false">取 消</el-button>
            <el-button type="primary" @click="addSimTir">确 定</el-button>
        </div>
    </el-dialog>
    <el-dialog title="添加任务" :visible.sync="dialogFormVisibleChange" v-if="ruleForm.resource==6">
        <el-form :model="form">
            <el-form-item label="任务名称" label-width="120px" style="width:35%">
                <el-input v-model="form.jobName" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="任务分组" label-width="120px" style="width:35%">
                <el-input v-model="form.jobGroup" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="表达式" label-width="120px" style="width:35%">
                <el-input v-model="form.cronExpression" auto-complete="off"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisibleChange = false">取 消</el-button>
            <el-button type="primary" @click="add">确 定</el-button>
        </div>
    </el-dialog>

    <el-dialog title="修改任务" :visible.sync="updateFormVisible">
        <el-form :model="updateform">
            <el-form-item label="表达式" label-width="120px" style="width:35%">
                <el-input v-model="updateform.cronExpression" auto-complete="off"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="updateFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="update">确 定</el-button>
        </div>
    </el-dialog>

</div>

<footer align="center">
    <p>&copy; Quartz 任务管理</p>
</footer>

<script>
    var vue = new Vue({
        el:"#test",
        data: {
            //表格当前页数据
            tableData: [],

            //请求的URL
            url:'job/queryjob',

            //默认每页数据量
            pagesize: 10,

            //当前页码
            currentPage: 1,

            //查询的页码
            start: 1,

            //默认数据总数
            totalCount: 1000,

            //添加对话框默认可见性
            dialogFormVisible: false,

            //修改对话框默认可见性
            updateFormVisible: false,
            //选择对话框
            dialogFormVisibleChange: false,

            checkboxChange:false,

            //提交的表单
            form: {
                jobName: '',
                jobGroup: '',
                cronExpression: '',
                timeType: ''
            },
            ruleForm: {
                resource: 3
            },

            updateform: {
                jobName: '',
                jobGroup: '',
                cronExpression: '',
            },
            options: [{
                value: 1,
                label: '年'
            }, {
                value: 2,
                label: '月'
            }, {
                value: 3,
                label: '天'
            }, {
                value: 4,
                label: '小时'
            }, {
                value: 5,
                label: '分钟'
            }, {
                value: 6,
                label: '周'
            },{
                value: 7,
                label: '秒'
            }],
            value4: ''
        },
        methods: {

            //从服务器读取数据
            loadData: function(pageNum, pageSize){
                this.$http.get('/job/queryjob?' + 'pageNum=' +  pageNum + '&pageSize=' + pageSize).then(function(res){
                    console.log(res)
                    this.tableData = res.body.JobAndTrigger.list;
                    this.totalCount = res.body.number;
                },function(){
                    console.log('failed');
                });
            },

            //单行删除
            handleDelete: function(index, row) {
                this.$http.post('/job/deletejob',{"jobClassName":row.job_NAME,"jobGroupName":row.job_GROUP},{emulateJSON: true}).then(function(res){
                    this.loadData( this.currentPage, this.pagesize);
                },function(){
                    console.log('failed');
                });
            },

            //暂停任务
            handlePause: function(index, row){
                this.$http.post('/job/pausejob',{"jobClassName":row.job_NAME,"jobGroupName":row.job_GROUP},{emulateJSON: true}).then(function(res){
                    this.loadData( this.currentPage, this.pagesize);
                },function(){
                    console.log('failed');
                });
            },

            //恢复任务
            handleResume: function(index, row){
                this.$http.post('/job/resumejob',{"jobClassName":row.job_NAME,"jobGroupName":row.job_GROUP},{emulateJSON: true}).then(function(res){
                    this.loadData( this.currentPage, this.pagesize);
                },function(){
                    console.log('failed');
                });
            },

            //搜索
            search: function(){
                this.loadData(this.currentPage, this.pagesize);
            },

            //弹出对话框
            handleadd: function(){
                this.checkboxChange = true;
            },
            change: function(){
                this.dialogFormVisibleChange = true;
            },

            //添加
            add: function(){
                this.$http.post('/job/addjob',{"jobClassName":this.form.jobName,"jobGroupName":this.form.jobGroup,"cronExpression":this.form.cronExpression}).then(function(res){
                    this.loadData(this.currentPage, this.pagesize);
                    this.dialogFormVisibleChange = false;
                    this.checkboxChange = false;
                },function(){
                    console.log('failed');
                });
            },
            addSimTir: function () {
                console.log(this.value4)
                this.$http.post('/job/addjob',{"jobClassName":this.form.jobName,"jobGroupName":this.form.jobGroup,"cronExpression":this.form.cronExpression,
                    "timeType":this.value4}).then(function(res){
                    this.loadData(this.currentPage, this.pagesize);
                    this.dialogFormVisibleChange = false;
                    this.checkboxChange = false;
                },function(){
                    console.log('failed');
                });
            },

            //更新
            handleUpdate: function(index, row){
                console.log(row)
                this.updateFormVisible = true;
                this.updateform.jobName = row.job_CLASS_NAME;
                this.updateform.jobGroup = row.job_GROUP;
            },

            //更新任务
            update: function(){
                this.$http.post
                ('/job/reschedulejob',
                    {"jobClassName":this.updateform.jobName,
                        "jobGroupName":this.updateform.jobGroup,
                        "cronExpression":this.updateform.cronExpression
                    },{emulateJSON: true}
                ).then(function(res){
                    this.loadData(this.currentPage, this.pagesize);
                    this.updateFormVisible = false;
                },function(){
                    console.log('failed');
                });

            },

            //每页显示数据量变更
            handleSizeChange: function(val) {
                this.pagesize = val;
                this.loadData(this.currentPage, this.pagesize);
            },

            //页码变更
            handleCurrentChange: function(val) {
                this.currentPage = val;
                this.loadData(this.currentPage, this.pagesize);
            },

        },


    });

    //载入数据
    vue.loadData(vue.currentPage, vue.pagesize);
</script>

</body>
</html>