$("#maintain_report_modal .report-body").html $("<%= escape_javascript(render('report_body', report: @maintain_history)) %>")
$("#maintain_report_modal").modal()
