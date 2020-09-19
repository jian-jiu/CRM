<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../../../../community/HeadPart.jsp" %>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: 'chart/transaction/findCountOfGroupByStage',
                type: 'post',
                datatype: 'json',
                success(data) {
                    // console.log(data)

                    let myChart = echarts.init(document.getElementById('div'))

                    let option = {
                        title: {
                            text: '交易统计视图',
                            subtext: '交易各个阶段数据量'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c}"
                        },
                        series: [
                            {
                                name: '交易阶段信息',
                                type: 'funnel',
                                left: '10%',
                                top: 60,
                                bottom: 60,
                                width: '80%',
                                min: 0,
                                // max: 100,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data
                            }
                        ]
                    };
                    myChart.setOption(option)
                }
            })
        })
    </script>
</head>
<body>
<div id="div" style="height: 100%; width: 100%;"></div>
</body>
</html>