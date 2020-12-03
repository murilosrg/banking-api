Banking.Repo.insert!(
  %Banking.User{
    email: "admin@email.com",
    employee: true,
    name: "Admin",
    password_hash: "$$2b$12$h5pn4F3T67J.2nHb8XitfufnAcrRWF6wdl0.8ub3hvGyF.1vAmlCK"
  },
  on_conflict: :replace_all,
  conflict_target: :email
)
