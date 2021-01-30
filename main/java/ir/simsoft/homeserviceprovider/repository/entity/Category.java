package ir.simsoft.homeserviceprovider.repository.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Category {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String name;
//    @JsonIgnore
//    @OneToMany(mappedBy = "category")
//    List<SubCategory> subCategoryList =new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

//    public List<SubCategory> getSubCategoryList() {
//        return subCategoryList;
//    }
//
//    public void setSubCategoryList(List<SubCategory> subCategoryList) {
//        this.subCategoryList = subCategoryList;
//    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
