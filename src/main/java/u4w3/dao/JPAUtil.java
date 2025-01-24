package u4w3.dao;

import static u4w3.Utils.*;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("CatalogoJPA");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static void close() {
        if (emf != null) {
            emf.close();
        }
    }

    public static void svuotaDatabase(EntityManager em) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();

            // Esegui TRUNCATE CASCADE sulle tabelle
            _W("Svuotamento del database in corso...");

            _W("Svuotamento della tabella prestiti...");
            em.createNativeQuery("TRUNCATE TABLE prestiti CASCADE").executeUpdate();

            _W("Svuotamento della tabella utenti...");
            em.createNativeQuery("TRUNCATE TABLE utenti CASCADE").executeUpdate();

            _W("Svuotamento della tabella libri...");
            em.createNativeQuery("TRUNCATE TABLE libri CASCADE").executeUpdate();

            _W("Svuotamento della tabella riviste...");
            em.createNativeQuery("TRUNCATE TABLE riviste CASCADE").executeUpdate();

            _W("Svuotamento della tabella elementi_catalogo...");
            em.createNativeQuery("TRUNCATE TABLE elementi_catalogo CASCADE").executeUpdate();

            transaction.commit();
            _W("Database svuotato con successo utilizzando TRUNCATE CASCADE.");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Errore durante lo svuotamento del database: " + e.getMessage());
        }
    }
}