package com.vinhkhanh.dao.impl;

import java.util.List;

import com.vinhkhanh.dao.NewslettersDAO;
import com.vinhkhanh.entity.Newsletters;
import com.vinhkhanh.utils.XJdbc;
import com.vinhkhanh.utils.XQuery;

public class NewslettersDAOImpl implements NewslettersDAO {
	private final String insertSql = "INSERT INTO dbo.Newsletters (Email, Enabled, SubscribedAt) VALUES (?,?,?)";
	private final String updateSql = "UPDATE dbo.Newsletters SET Enabled = ?, SubscribedAt = ? WHERE Email = ?";
	private final String deleteByIdSql = "DELETE FROM dbo.Newsletters WHERE Email = ?";
	private final String findAllSql = "SELECT * FROM dbo.Newsletters";
	private final String findByIdSql = findAllSql + " WHERE Email = ?";

	@Override
	public Newsletters create(Newsletters entity) {
		Object[] values = {
				entity.getEmail(),
				entity.getEnabled(),
				entity.getSubscribedAt()
		};
		XJdbc.executeUpdate(insertSql, values);
		return entity;
	}

	@Override
	public void update(Newsletters entity) {
		Object[] values = {
				entity.getEnabled(),
				entity.getSubscribedAt(),
				entity.getEmail()
		};
		XJdbc.executeUpdate(updateSql, values);
	}

	@Override
	public void deleteById(String id) {
		XJdbc.executeUpdate(deleteByIdSql, id);
	}

	@Override
	public List<Newsletters> findAll() {
		return XQuery.getBeanList(Newsletters.class, findAllSql);
	}

	@Override
	public Newsletters findById(String id) {
		return XQuery.getSingleBean(Newsletters.class, findByIdSql, id);
	}

}
