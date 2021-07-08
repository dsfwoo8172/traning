module ApplicationHelper

  def translate_order(order)
    case order
    when "low"
      "低"
    when "middle"
      "中"
    else
      "高"
    end
  end

  def translate_states(state)
    case state
    when "pending"
      "待處理"
    when "proccesing"
      "處理中"
    else
      "已完成"
    end
  end

  def translate_role(role)
    case role
    when "admin"
      "管理員"
    else
      "一般使用者"
    end
  end

  def order_select_options
    Task.priorities.keys.map{|order| [translate_order(order), order]}
  end

  def state_select_options
    Task.states.keys.map{|state| [translate_states(state), state]}
  end
end
