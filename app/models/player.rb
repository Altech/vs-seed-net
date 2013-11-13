# -*- coding: utf-8 -*-
class Player < ActiveRecord::Base
  validates :name,
    uniqueness: true,
    length: { minimum: 1, maximum: 10 }
  validates :mail,
    uniqueness: true,
    email_format: true
  has_secure_password
  validates :password, length: { minimum: 8, maximum: 20 }
end
