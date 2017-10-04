# encoding: UTF-8

module Utils

  def javascript_scroll(px_down)
    execute_script("window.scrollBy(0, #{px_down})", '')
    sleep 1
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

end
