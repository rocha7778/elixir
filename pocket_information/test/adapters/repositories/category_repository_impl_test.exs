defmodule PocketInformation.Test.Adapters.Repositories.CategoryRepositoryImplTest do
  use ExUnit.Case

  import Mock

  alias PocketInformation.Adapters.Repositories.CategoryRepositoryImpl
  alias PocketInformation.Adapters.Cache.CacheImpl
  alias PocketInformation.Domain.Model.Pocket.Category

  describe "get cached category " do
    test "Category exists in cache" do
      with_mock CacheImpl, get_reference: fn _code -> {:ok, "stethoscope"} end do
        {:ok, category} = Category.new("0001", nil)

        assert {:ok, %Category{id: "0001", reference: "stethoscope"}} ==
                 CategoryRepositoryImpl.get_category(category)
      end
    end
  end

  describe "get category in MongoDB" do
    test "should return an error because the references does not exist" do
      with_mocks([
        {CacheImpl, [], [get_reference: fn _code -> {:error, :reference_not_cached} end]},
        {Mongo, [],
         [
           find: fn _topology_pid, _coll, _filter -> [] end
         ]}
      ]) do
        {:ok, category} = Category.new("0001", nil)

        assert {:error, "No se encontraron las referencias"} ==
                 CategoryRepositoryImpl.get_category(category)
      end
    end

    test "should return an error because the reference for the code does not exist" do
      with_mocks([
        {CacheImpl, [], [get_reference: fn _code -> {:error, :reference_not_cached} end]},
        {Mongo, [],
         [
           find: fn _topology_pid, _coll, _filter ->
             [
               %{"Codigo_de_categoria" => 1, "Referencia_imagen_categoria" => "stethoscope"},
               %{"Codigo_de_categoria" => 2, "Referencia_imagen_categoria" => "utensils"},
               %{"Codigo_de_categoria" => 3, "Referencia_imagen_categoria" => "cocktail"}
             ]
           end
         ]}
      ]) do
        {:ok, category} = Category.new("0008", nil)

        assert {:error, "No se encontro la referencia"} ==
                 CategoryRepositoryImpl.get_category(category)
      end
    end

    test "should return the value of the reference of the searched code" do
      with_mock Mongo,
        find: fn _topology_pid, _coll, _filter ->
          [
            %{"Codigo_de_categoria" => 1, "Referencia_imagen_categoria" => "stethoscope"},
            %{"Codigo_de_categoria" => 2, "Referencia_imagen_categoria" => "utensils"},
            %{"Codigo_de_categoria" => 3, "Referencia_imagen_categoria" => "cocktail"}
          ]
        end do
        CacheImpl.start()
        {:ok, category} = Category.new("0003", nil)

        assert {:ok, %Category{id: "0003", reference: "cocktail"}} ==
                 CategoryRepositoryImpl.get_category(category)
      end
    end
  end
end
