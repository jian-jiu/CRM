package com.simple.crm.workbench.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 统计视图数据
 *
 * @author 简单
 * @date 2020/9/18
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class FunnelVO {
    private String name;
    private String value;
}
