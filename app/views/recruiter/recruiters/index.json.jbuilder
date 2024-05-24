json.array!(@recruiters) do |recruiter|
  json.partial! 'recruiter', recruiter: recruiter
end
