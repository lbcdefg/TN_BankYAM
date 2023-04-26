package tn.bankYam.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
	private long pd_seq;
	private String pd_type;
	private String pd_name;
	private float pd_rate;
	private float pd_addrate;
	private String pd_info;
	private String pd_del;
	private Date pd_rdate;
	private Date pd_xdate;
}
