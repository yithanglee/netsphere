defmodule CommerceFront.Settings do
  @moduledoc """
  The Settings context.
  """
  require Logger
  import Mogrify
  import Ecto.Query, warn: false
  alias CommerceFront.Repo
  require IEx

  alias Ecto.Multi

  alias CommerceFront.Settings.User

  def auth_user(params) do
    user =
      Repo.all(from(u in User, where: u.username == ^params["username"]))
      |> List.first()

    with true <- user != nil,
         crypted_password <-
           :crypto.hash(:sha512, params["password"]) |> Base.encode16() |> String.downcase(),
         true <- crypted_password == user.crypted_password do
      {:ok, user}
    else
      _ ->
        {:error}
    end
  end

  def list_users() do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(attrs \\ %{}) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    User.changeset(%User{}, attrs) |> Repo.insert() |> IO.inspect()
  end

  def update_user(model, attrs) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    User.changeset(model, attrs) |> Repo.update() |> IO.inspect()
  end

  def delete_user(%User{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Placement

  def list_placements() do
    Repo.all(Placement)
  end

  def get_placement_by_username(username) do
    if username == "admin" do
      %{id: 0, user_id: 0}
    else
      res = Repo.all(from(u in User, where: u.username == ^username)) |> List.first()

      if res != nil do
        Repo.get_by(Placement, user_id: res.id)
      end
    end
  end

  def get_placement!(id) do
    Repo.get!(Placement, id)
  end

  def create_placement(params \\ %{}) do
    Placement.changeset(%Placement{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_placement(model, params) do
    Placement.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_placement(%Placement{} = model) do
    Repo.delete(model)
  end

  def determine_position(username) do
    if username == "admin" do
      "left"
    else
      # here need to check if the position here has full
      list =
        CommerceFront.Settings.check_downlines(username)
        |> Enum.reject(&(&1 |> Map.get(:children) |> Enum.count() == 2))

      # then determine position left right
      check =
        list
        |> List.first()
        |> Map.get(:children)
        |> Enum.map(&(&1 |> String.contains?("left")))
        |> Enum.uniq()
        |> List.first()

      with true <- check != nil,
           true <- check do
        "right"
      else
        _ ->
          "left"
      end
    end
  end

  def register(params) do
    Multi.new()
    |> Multi.run(:user, fn _repo, %{} ->
      create_user(params)
    end)
    |> Multi.run(:placement, fn _repo, %{user: user} ->
      parent_p = get_placement_by_username(params["sponsor"])
      position = determine_position(params["sponsor"])

      create_placement(%{
        parent_user_id: parent_p.user_id,
        parent_placement_id: parent_p.id,
        position: position,
        user_id: user.id
      })
    end)
    |> Repo.transaction()
    |> IO.inspect()
    |> case do
      {:ok, multi_res} ->
        {:ok, multi_res |> Map.get(:user)}

      _ ->
        {:error, []}
    end
  end

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def check_uplines(child_username) do
    child_user = get_user_by_username(child_username)
    child_user_id = child_user.id

    category_tree_initial_query =
      Placement
      |> where([sp], sp.user_id == ^child_user_id)

    category_tree_recursion_query =
      Placement
      |> join(:inner, [sp], pt in "placement_tree", on: sp.user_id == pt.parent_user_id)

    category_tree_query =
      category_tree_initial_query
      |> union_all(^category_tree_recursion_query)

    User
    |> recursive_ctes(true)
    |> with_cte("placement_tree", as: ^category_tree_query)
    |> join(:left, [m], pt in "placement_tree", on: m.id == pt.user_id)
    |> join(:left, [m, pt], m2 in User, on: m2.id == pt.parent_user_id)
    |> where([m, pt, m2], m.id <= ^child_user_id)
    |> where([m, pt, m2], not is_nil(m2.id))
    |> select([m, pt, m2], %{
      child_id: m.id,
      child: m.username,
      pt_child_id: pt.id,
      pt_parent_id: pt.parent_placement_id,
      parent: m2.username,
      parent_id: m2.id
    })
    |> order_by([m, pt, m2], desc: m.id)
    |> Repo.all()
  end

  def check_downlines(parent_username) do
    parent_user = get_user_by_username(parent_username)
    parent_user_id = parent_user.id

    category_tree_initial_query =
      Placement
      |> where([sp], sp.parent_user_id == ^parent_user_id)

    category_tree_recursion_query =
      Placement
      |> join(:inner, [sp], pt in "placement_tree", on: sp.parent_user_id == pt.user_id)

    category_tree_query =
      category_tree_initial_query
      |> union_all(^category_tree_recursion_query)

    User
    |> recursive_ctes(true)
    |> with_cte("placement_tree", as: ^category_tree_query)
    |> join(:left, [m], pt in "placement_tree", on: m.id == pt.user_id)
    |> join(:left, [m, pt], m2 in User, on: m2.id == pt.parent_user_id)
    |> where([m, pt, m2], m.id > ^parent_user_id)
    |> where([m, pt, m2], not is_nil(m2.id))
    |> group_by([m, pt, m2], [m2.id])
    |> select([m, pt, m2], %{
      children:
        fragment(
          "ARRAY_AGG( CONCAT(?, ?, ?, ?, ?, ?, ?) )",
          m.username,
          "|",
          m.id,
          "|",
          m.fullname,
          "|",
          pt.position
        ),
      parent: m2.fullname,
      parent_username: m2.username,
      parent_id: m2.id
    })
    |> Repo.all()

    # |> select([m, pt, m2], %{
    #   child_id: m.id,
    #   child: m.name,
    #   child_code: m.code,
    #   pt_child_id: pt.child_user_id,
    #   pt_parent_id: pt.parent_user_id,
    #   parent: m2.name,
    #   parent_username: m2.code,
    #   parent_id: m2.id
    # })
  end

  def reset do
    Repo.delete_all(User)
    Repo.delete_all(Placement)
  end
end
