Banking.Repo.insert!(
  %Banking.User{
    email: "admin@email.com",
    employee: true,
    name: "Admin",
    password_hash: "$2b$12$Tx/1Jc2AXiLCNJX8dFUoneVzVQzqgb1Y3OeIYCKO6B66Yde3hDwym"
  },
  on_conflict: :replace_all,
  conflict_target: :email
)
