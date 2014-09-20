#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Mecha と MechaName は相互参照しているので、これが壊れた場合同期する。

Mecha.all.each do |mecha|
  mecha_name = MechaName.find mecha.full_name_id
  mecha_name.update_attribute(:mecha_id, mecha.id)

  mecha_name = MechaName.find mecha.nickname_id
  mecha_name.update_attribute(:mecha_id, mecha.id)
end
