package com.plamenpetkovonline.springbootecommerce.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.metamodel.EntityType;

import com.plamenpetkovonline.springbootecommerce.entity.Product;
import com.plamenpetkovonline.springbootecommerce.entity.ProductCategory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;

@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {

    @Autowired
    private EntityManager entityManager;

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config) {
        HttpMethod[] theUnsupportedActions = {HttpMethod.PUT, HttpMethod.DELETE, HttpMethod.POST};

        // disable the unsupported (for now) HTTP methods for Product
        config.getExposureConfiguration()
            .forDomainType(Product.class)
            .withItemExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
            .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions));

        // disable the unsupported (for now) HTTP methods for ProductCategory
        config.getExposureConfiguration()
        .forDomainType(ProductCategory.class)
        .withItemExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
        .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions));
        exposeIds(config);
        
    }

    private void exposeIds(RepositoryRestConfiguration config) {
        // get a list of all entity classes from the entity manager
        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();

        // create an array of the entity types
        List<Class> entityClasses = new ArrayList<>();

        // get the entity types for the entities
        for (EntityType tempEntityType : entities) {
            entityClasses.add(tempEntityType.getJavaType());
        }

        // expose the entity ids for the array of entity/domain types
        Class[] domainTypes = entityClasses.toArray(new Class[0]);
        config.exposeIdsFor(domainTypes);
    }
    
}
