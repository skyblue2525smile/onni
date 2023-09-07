class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
  end
  # トップページにて新着商品を４件表示する

  def introduction

  end
end
